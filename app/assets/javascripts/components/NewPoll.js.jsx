var NewPoll = React.createClass({
  getInitialState: function() {
    return {
      options: ["", "", "", ""]
    }
  },
  addOption: function(e) {
    e.preventDefault();
    this.state.options.push("")
    this.setState({
      options: this.state.options
    });
  },
  removeOption: function(index) {
    this.state.options.splice(index, 1);
    this.setState({
      options: this.state.options
    });
  },
  handleChange: function(index, e) {
    this.state.options[index] = e.target.value;
    this.setState({
      options: this.state.options
    });
  },
  render: function() {
    let remove = this.removeOption;
    let handleOptionChange = this.handleChange;
    let options = this.state.options;
    var optionsInputs = this.state.options.map(function(option, index) {
      return (
        <div key={index}>
          <input type="button" value="-" onClick={() => remove(index)} />
          <input key={index} id={index} name="poll[options][]" type="text" onChange={(evt) => handleOptionChange(index, evt)} value={options[index]} placeholder="Write option here"/>
          <br />
        </div>
      );
    });
    return (
      <div>
        <form action="/polls" id="new_poll" method="post">
          <input name="authenticity_token" type="hidden" value={this.props.authenticity_token} />
          <label for="poll_title">Title</label>:
          <input id="poll_title" name="poll[title]" type="text" /><br />
          <label>Options:</label>
          <br />
          {optionsInputs}
          <input type="radio" name="poll[public]" value="false" /> False<br />
          <input type="radio" name="poll[public]" value="true" /> True<br />
          <button type="button" onClick={this.addOption}>Add option</button>
          <input name="commit" type="submit" value="Create Poll" />
        </form>
      </div>
    );
  }
});